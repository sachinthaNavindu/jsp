    function loadEmployeeData(nic, name, address, contact, role) {
    document.getElementById('nic').value = nic;
    document.getElementById('name').value = name;
    document.getElementById('address').value = address;
    document.getElementById('contact').value = contact;
    document.getElementById('role').value = role;

    document.getElementById('nic').readOnly = true;

    const updateBtn = document.getElementById('updateBtn');
    updateBtn.disabled = false;
    updateBtn.classList.remove('btn-disabled');
}

    document.addEventListener('click', function(e) {
    if (!e.target.closest('table') && !e.target.closest('#employeeForm')) {
    resetForm();
}
});

    function resetForm() {
    document.getElementById('employeeForm').reset();
    document.getElementById('nic').readOnly = false;

    const updateBtn = document.getElementById('updateBtn');
    updateBtn.disabled = true;
    updateBtn.classList.add('btn-disabled');
}

    function validateNIC(nic) {
    const oldNicPattern = /^[0-9]{9}[vVxX]$/;
    const newNicPattern = /^[0-9]{12}$/;

    return oldNicPattern.test(nic) || newNicPattern.test(nic);
}

    function validateContactNumber(contact) {
    const pattern = /^0[0-9]{9}$/;
    return pattern.test(contact);
}

    document.getElementById('nic').addEventListener('blur', function() {
    const nic = this.value.trim();
    const errorElement = document.getElementById('nicError') || createErrorElement(this, 'nicError');

    if (nic === '') {
    errorElement.textContent = 'NIC is required';
    this.classList.add('is-invalid');
    return;
}

    if (!validateNIC(nic)) {
    errorElement.textContent = 'Please enter a valid NIC (10 digits ending with V/X or 12 digits)';
    this.classList.add('is-invalid');
} else {
    errorElement.textContent = '';
    this.classList.remove('is-invalid');
}
});

    document.getElementById('contact').addEventListener('blur', function() {
    const contact = this.value.trim();
    const errorElement = document.getElementById('contactError') || createErrorElement(this, 'contactError');

    if (contact === '') {
    errorElement.textContent = 'Contact number is required';
    this.classList.add('is-invalid');
    return;
}

    if (!validateContactNumber(contact)) {
    errorElement.textContent = 'Please enter a valid 10-digit phone number starting with 0';
    this.classList.add('is-invalid');
} else {
    errorElement.textContent = '';
    this.classList.remove('is-invalid');
}
});

    function createErrorElement(inputElement, id) {
    const errorElement = document.createElement('div');
    errorElement.id = id;
    errorElement.className = 'invalid-feedback';
    inputElement.parentNode.appendChild(errorElement);
    return errorElement;
}

    document.getElementById('employeeForm').addEventListener('submit', function(e) {
    const nic = document.getElementById('nic').value.trim();
    const contact = document.getElementById('contact').value.trim();

    if (!validateNIC(nic)) {
    e.preventDefault();
    alert('Please enter a valid NIC number');
    document.getElementById('nic').focus();
    return;
}

    if (!validateContactNumber(contact)) {
    e.preventDefault();
    alert('Please enter a valid contact number');
    document.getElementById('contact').focus();
    return;
}
});

